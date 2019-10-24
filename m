From: Dmitry Vyukov via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2 1/3] kcov: remote coverage support
Date: Thu, 24 Oct 2019 09:26:52 +0200
Message-ID: <CACT4Y+a6t08RmtSYfF=3TuASx9ReCEe0Qp0AP=GbCtNyL2j+TA__49231.1456868023$1571902035$gmane$org@mail.gmail.com>
References: <cover.1571844200.git.andreyknvl@google.com>
	<beeae42e313ef57b4630cc9f36e2e78ad42fd5b7.1571844200.git.andreyknvl@google.com>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <beeae42e313ef57b4630cc9f36e2e78ad42fd5b7.1571844200.git.andreyknvl@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Marco Elver <elver@google.com>, Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, KVM list <kvm@vger.kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Elena Reshetova <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 23, 2019 at 5:24 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patch adds background thread coverage collection ability to kcov.
...
> +static struct kcov_remote *kcov_remote_add(struct kcov *kcov, u64 handle)
> +{
> +       struct kcov_remote *remote;
> +
> +       if (kcov_remote_find(handle))
> +               return ERR_PTR(-EEXIST);
> +       remote = kmalloc(sizeof(*remote), GFP_ATOMIC);
> +       if (!remote)
> +               return ERR_PTR(-ENOMEM);
> +       remote->handle = handle;
> +       remote->kcov = kcov;
> +       hash_add(kcov_remote_map, &remote->hnode, handle);

I think it will make sense to check that there is no existing kcov
with the same handle registered. Such condition will be extremely hard
to debug based on episodically missing coverage.

...
>  void kcov_task_exit(struct task_struct *t)
>  {
>         struct kcov *kcov;
> @@ -256,15 +401,23 @@ void kcov_task_exit(struct task_struct *t)
>         kcov = t->kcov;
>         if (kcov == NULL)
>                 return;
> +
>         spin_lock(&kcov->lock);
> +       kcov_debug("t = %px, kcov->t = %px\n", t, kcov->t);
> +       /*
> +        * If !kcov->remote, this checks that t->kcov->t == t.
> +        * If kcov->remote == true then the exiting task is either:
> +        * 1. a remote task between kcov_remote_start() and kcov_remote_stop(),
> +        *    in this case t != kcov->t and we'll print a warning; or

Why? Is kcov->t == NULL for remote kcov's? May be worth mentioning in
the comment b/c it's a very condensed form to check lots of different
things at once.

Otherwise the series look good to me:

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

But Andrew's comments stand. It's possible I understand all of this
only because I already know how it works and why it works this way.

From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 0/7] More lguest massage.
Date: Thu, 17 Jan 2008 23:02:42 -0200
Message-ID: <5d6222a80801171702v5b4ef40ai67b5febd4d74c470__1483.85505094684$1200618397$gmane$org@mail.gmail.com>
References: <1200616550283-git-send-email-gcosta@redhat.com>
	<12006165571406-git-send-email-gcosta@redhat.com>
	<1200616561270-git-send-email-gcosta@redhat.com>
	<12006165651341-git-send-email-gcosta@redhat.com>
	<12006165701019-git-send-email-gcosta@redhat.com>
	<12006165743557-git-send-email-gcosta@redhat.com>
	<12006165781954-git-send-email-gcosta@redhat.com>
	<12006165841070-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12006165841070-git-send-email-gcosta@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I don't have _any_ idea about what happened to those patches. They
were sent through the normal git-send-email script, but for
some reason, all got the same subject. They might be okay for the
review, but anyone willing to try it more seriously, please grab it
at http://glommer.net/patches-lguest.tar.gz

On Jan 17, 2008 10:35 PM, Glauber de Oliveira Costa <gcosta@redhat.com> wrote:
> urrently, lguest module can't be compiled without the PARAVIRT flag being
> on.This is a fake dependency, since the module itself shouldn't need any
> paravirtoverride. Reason for that is the reference to pv_info structure
> ininitial loading tests.
>
> his patch removes it in favour of a more generic error message.
>
> Signed-off-by:Glauber de Oliveira Costa <gcosta@redhat.com>
> ---
> drivers/lguest/core.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff--git a/drivers/lguest/core.c b/drivers/lguest/core.c
> indexbb42fd0..97b76d6 100644
> ---a/drivers/lguest/core.c
> +++b/drivers/lguest/core.c
> @@-255,7 +255,7 @@ static int __init init(void)
>
>         /* Lguest can't run under Xen, VMI or itself.  It does Tricky Stuff. */
>         if (paravirt_enabled()) {
> -               printk("lguestis afraid of %s\n", pv_info.name);
> +               printk("lguestcan't run under another hypervisor");
>                 return -EPERM;
>         }
>
> --
> 1.5.0.6
>
>



-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."

From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [patch 8/9] Guest page hinting: discarded page list.
Date: Fri, 01 Sep 2006 08:17:16 -0700
Message-ID: <1157123836.28577.77.camel@localhost.localdomain>
References: <20060901111117.GI15684@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060901111117.GI15684@skybase>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, rhim@cc.gateh.edu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 13:11 +0200, Martin Schwidefsky wrote:
> =

> +#if defined(CONFIG_PAGE_DISCARD_LIST)
> +       if (page_host_discards() && unlikely(PageDiscarded(page))) {
> +               local_irq_disable();
> +               list_add_tail(&page->lru,
> +                             &__get_cpu_var(page_discard_list));
> +               local_irq_enable();
> +               return;
> +       }
> +#endif =


If PageDiscarded() was #ifdef'd in the header, you wouldn't need this in
the .c file.

-- Dave

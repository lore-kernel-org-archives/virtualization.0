From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
Date: Fri, 01 Sep 2006 08:33:41 -0700
Message-ID: <1157124821.28577.88.camel@localhost.localdomain>
References: <20060901110908.GB15684@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060901110908.GB15684@skybase>
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

On Fri, 2006-09-01 at 13:09 +0200, Martin Schwidefsky wrote:
> +++ linux-2.6-patched/mm/page_alloc.c   2006-09-01 12:49:35.000000000
> +0200
> @@ -515,6 +515,7 @@ static void __free_pages_ok(struct page =

>                 reserved +=3D free_pages_check(page + i);
>         if (reserved)
>                 return;
> +       page_set_unused(page, order);
>  =

>         kernel_map_pages(page, 1 << order, 0);
>         local_irq_save(flags); =


Do these have anything in common with arch_free_page()?  I thought
marking the pages as being "unused by the kernel" was the whole idea of
having that hook.

-- Dave

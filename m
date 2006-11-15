From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm2: paravirt X86_PAE=y compile error
Date: Wed, 15 Nov 2006 15:36:14 -0800
Message-ID: <20061115153614.a71f944d.akpm@osdl.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061115231626.GC31879@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061115231626.GC31879@stusta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 16 Nov 2006 00:16:26 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> Paravirt breaks CONFIG_X86_PAE=3Dy compilation:
> =

> <--  snip  -->
> =

> ...
>   CC      init/main.o
> In file included from include2/asm/pgtable.h:245,
>                  from =

> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/mm.h:40,
>                  from =

> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/poll.h:11,
>                  from =

> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/rtc.h:113,
>                  from =

> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/efi.h:19,
>                  from =

> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/init/main.c:43:
> include2/asm/pgtable-3level.h:108: error: redefinition of 'pte_clear'
> include2/asm/paravirt.h:365: error: previous definition of 'pte_clear' wa=
s here
> include2/asm/pgtable-3level.h:115: error: redefinition of 'pmd_clear'
> include2/asm/paravirt.h:370: error: previous definition of 'pmd_clear' wa=
s here
> make[2]: *** [init/main.o] Error 1
> =


So it does.  Zach will save us.

How come allmodconfig doesn't select highmem?

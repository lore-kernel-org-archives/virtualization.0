From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] fix boot crash when freeing initrd memory
Date: Wed, 01 Nov 2006 14:49:31 -0800
Message-ID: <4549247B.2070403@goop.org>
References: <Pine.LNX.4.44.0611011729170.31570-100000@redline.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0611011729170.31570-100000@redline.boston.redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: James Morris <jmorris@redhat.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

James Morris wrote:
> I'm triggering this BUG_ON during boot, which happens while freeing initr=
d =

> memory:
>
>  EIP is at free_init_pages+0x37/0xac
>  [<c01143f1>] free_initrd_mem+0x11/0x13
>  [<c03ce259>] free_initrd+0x13/0x29
>  [<c03cf647>] populate_rootfs+0xdc/0xe2
>  [<c01003af>] init+0x42/0x253
>  [<c0103bbb>] kernel_thread_helper+0x7/0x10
>
>
> I'm not sure why this memory isn't aligned now.
>
> The patch below allows my system to boot.  Any clues about the correct fix
> appreciated.
>   =


Is this booting native or under Xen?  I put the BUG_ON in there since if =

it isn't page-aligned, freeing the page would seem to be freeing =

something else unexpectedly...  I think ChrisW was triggering this =

BUG_ON at one point, but I don't think we've worked out what's going on =

here.

    J

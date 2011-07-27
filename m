From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Re: [PATCH 0/5] Collected vdso/vsyscall fixes for 3.1
Date: Wed, 27 Jul 2011 12:29:57 -0400
Message-ID: <20110727162956.GA16931__37815.0163837292$1311784346$gmane$org@dumpdata.com>
References: <cover.1311736366.git.luto@mit.edu>
	<20110727145745.GA11872@dumpdata.com>
	<CAObL_7FT8QLg-wihasBahhAtS=pA7+KeU8E=E9x8NPZ0+QJ5iQ@mail.gmail.com>
	<20110727153015.GA16688@dumpdata.com>
	<CAObL_7GWGx4rYJFLpucEX=ozNpk+5ipyq0=vw16xcGetEXSuGQ@mail.gmail.com>
	<20110727154316.GA16909@dumpdata.com>
	<CAObL_7FncQ7DdNf2igFZW=ZzPFQLO3Vvp1c_y5EajA_KTt8iOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAObL_7FncQ7DdNf2igFZW=ZzPFQLO3Vvp1c_y5EajA_KTt8iOg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: xen-devel@lists.xensource.com, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, keir.xen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

> 400c8d:       c4 e1 f3 2a c8          vcvtsi2sd %rax,%xmm1,%xmm1
> 
> which is unlikely to work on AMD unless you're the lucky owner of a
> prerelease Bulldozer chip.  I
> 
> I bet if you pull a new copy or remove -mavx from Makefile it will
> work.  I got a grossly hacked-up Xen domU booted and everything seems
> to work.

Ok.
> 
> (Testing native kernels is really fun with qemu-kvm -kernel <image>
> -initrd <my silly initramfs>.  But Xen doesn't seem to support that.)

You mean running Xen within QEMU? It does, but you need to use a multiboot
loader and QEMU does not seem to support that. You can create an
.iso image with isolinux that loads mboot.c32 for that.

If you want to use qemu like that in Xen environment you can do it too.
Just need the upstream version and use -M xenpv

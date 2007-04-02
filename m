From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/2] Use a single loader for i386 and x86_64
Date: Tue, 03 Apr 2007 09:32:49 +1000
Message-ID: <1175556769.12230.462.camel@localhost.localdomain>
References: <20070402194344.GA7711@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966101AbXDBXd0@vger.kernel.org>
In-Reply-To: <20070402194344.GA7711@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-04-02 at 16:43 -0300, Glauber de Oliveira Costa wrote:
> This patch moves lguest.c one level bellow, and enhances it with the
> ability to kick off 64 binaries. It would be much easier to just ifdef
> functions, but I have x86_64 machines loading 32-bit kernels as a longer
> goal, and that's why the patch features the load_elf_header() function.

Hi Glauber!

	I've been writing documentation, and in the process completely
reorganised and cleaned up this file.  I have also been working on
getting rid of the gratuitous u32's for addresses and trying to cleanse
myself of 32-bit thinking!

	I've now pushed the changes to the repo.  They should simplify this
patch...

Thanks!
Rusty.

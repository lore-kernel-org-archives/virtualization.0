From: Amit Shah <amit.shah@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 0/24] paravirt_ops for unified x86 - that's
	me again!
Date: Mon, 12 Nov 2007 13:47:19 +0530
Message-ID: <200711121347.20050.amit.shah__28136.3319409595$1194855540$gmane$org@qumranet.com>
References: <11946337851964-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11946337851964-git-send-email-gcosta@redhat.com>
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
To: kvm-devel@lists.sourceforge.net, Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, akpm@linux-foundation.org, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 10 November 2007 00:12:41 Glauber de Oliveira Costa wrote:
> Hey folks,
>
> Here's a new spin of the pvops64 patch series.
> We didn't get that many comments from the last time,
> so it should be probably almost ready to get in. Heya!
>
> >From the last version, the most notable changes are:
>
> * consolidation of system.h, merging jeremy's comments about ordering
>   concerns
> * consolidation of smp functions that goes through smp_ops. They're sharing
>   a bunch of code now.
>
> Other than that, just some issues that arose from the rebase.
>
> Please, not that this patch series _does not_ apply over linus git anymore,
> but rather, over tglx cleanup series.
>
> The first patch in this series is already on linus', but not on tglx', so
> I'm sending it again, because you'll need it if you want to compile it
> anyway.
>
> tglx, in the absense of any outstanding NACKs, or any very big call for
> improvements, could you please pull it in your tree?
>
> Have fun,

Glauber, are you planning on consolidating the dma_ops structure for 32- and 
64-bit? 32-bit doesn't currently have a dma_mapping_ops structure, which 
makes paravirtualizing DMA access difficult on 32-bit.

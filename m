From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: RE: [kvm-devel] [PATCH 3/3] Eliminate read_cr3 on TLB flush
Date: Wed, 30 May 2007 12:12:07 -0700
Message-ID: <97D612E30E1F88419025B06CB4CF1BE10259AD95__30879.2683099911$1180552393$gmane$org@scsmsx412.amr.corp.intel.com>
References: <465DBB49.5030503@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <465DBB49.5030503@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Nakajima, Jun wrote:
> > And actually you don't need the write to CR3 to flush TLB because
the
> > one to CR4 does it. Or does kvm_flush_tlb_kernel assume that CR3 is
updated
> > at the same time? 
> > 
> > Jun
> 
> It should not be necessary, but I believe this was added as a
workaround
> to a PII erratum.  I can't find the erratum, however, and the history
of
> using G bits in Linux is complicated (several bugs introduced and many
> intermediate versions of this code).  Since this is not performance
> critical, I think it is probably best to leave the CR3 reload.

I don't recommend this for old processors.

> 
> However, being unnecessary on modern processors, I already submitted a
> patch to eliminate it on 64-bit (or maybe just told Andi about it, I
> can't recall).
> 
> Zach

For KVM, it should be okay as well. But we can replace two CR4 accesses
with just one hypercall.

Jun
---
Intel Open Source Technology Center

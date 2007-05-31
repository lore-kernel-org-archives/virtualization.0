From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH RFC 3/3] virtio infrastructure: example block
 driver
Date: Thu, 31 May 2007 19:01:38 +0200
Message-ID: <465EFF72.5070100__15374.5967233137$1180630986$gmane$org@de.ibm.com>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<1180614044.11133.61.camel@localhost.localdomain>
	<1180614091.11133.63.camel@localhost.localdomain>
	<465EC637.7020504@de.ibm.com>
	<20070531150206.GB6474@narn.hozed.org>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070531150206.GB6474@narn.hozed.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Troy Benjegerdes <hozer@hozed.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, carsteno@de.ibm.com, mschwid2@linux.vnet.ibm.com, virtualization <virtualization@lists.linux-foundation.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, Suzanne McIntosh <skranjac@us.ibm.com>, Christian Borntraeger <cborntra@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Troy Benjegerdes wrote:
> This kind of a claim needs some benchmark data to document it.
We've implemented both for our vdisk driver on 390. At least on our 
platform, merging in the host is preferable because vmenter/vmexit is 
very fast and we would merge twice because we submit the result via 
io_submit() system call from host userland.
In the end you'd need to measure on all platforms this is gonna run 
on, if you want competitive benchmarks. That makes the benchmark 
argument somewhat fuzzy.

> I'll make the counterclaim that you *should* be doing I/O scheduling in
> the guest, both to be able to test new I/O schedulers, and to provide
> a set of pre-scheduled I/Os so the host has to do less work.
What makes the work to merge requests less, if done in the host? Is'nt 
it the same code really if you run Linux in both host and guest?

> If someone really needs the host to be doing I/O scheduling, and not the
> guest, then why are they using virtualization in the first place?
Just to run multiple operating systems on one box. Funny question...

so long,
Carsten

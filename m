From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [kvm-devel] [RFC/PATCH 00/15] kvm on big iron
Date: Fri, 21 Mar 2008 12:22:23 +0100
Message-ID: <47E39A6F.2080709@de.ibm.com>
References: <1206030270.6690.51.camel@cotte.boeblingen.de.ibm.com>
	<47E395C9.6050201@qumranet.com>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E395C9.6050201@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: Rik van Riel <riel@redhat.com>, Christian Ehrhardt <EHRHARDT@de.ibm.com>, Andrea Arcangeli <andrea@qumranet.com>, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, jeroney@us.ibm.com, borntrae@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Carsten Otte wrote:
>> This patch series introduces a backend for kvm to run on IBM System z
>> machines that uses the mainframe's sie virtualization capability. This
>> work runs 64bit guests on z800/z890/z900/z990/z9/z10 class machines with
>> a 64bit linux host. Userspace will follow once we're done brushing it
>> over.
>>   
> 
> I'm slightly worried about the changes to non arch code.  Perhaps Andrea 
> or Rik can look over the mm/ changes and ack?
Yea that's why I've copied linux-mm on the first two patches. 
Reallocating the page tables works sane and is simple, but whether or 
not we may export dup_mm is the real question.

> Other than that, and the few minor comments that popped up, this (very 
> nice) patchset will be very easy to merge.  IIRC you mentioned it is 
> possible for me to get an s390 account; this will be very useful in 
> avoiding breaking this port, as happens quite often with ppc and ia64.  
> I'd like to be able to do both build and run testing.
Glad to hear that you like the patchset. It would be cool if you could 
pull from Linus soon, because we do need a patch not yet in the 
kvm.git that the series is based upon. After that, we'll integrate the 
review feedback, rebase to latest git, and resubmit the series.

I'll see what I can do to get you access to a box. We'll also be 
following kvm.git closely during the kernel release cycles and report 
regressions or submit patches to clean them up.

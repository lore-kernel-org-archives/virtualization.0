From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [RFC/PATCH 00/15] kvm on big iron
Date: Fri, 21 Mar 2008 13:02:33 +0200
Message-ID: <47E395C9.6050201__17474.5287550197$1206097799$gmane$org@qumranet.com>
References: <1206030270.6690.51.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206030270.6690.51.camel@cotte.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carsten Otte <cotte@de.ibm.com>
Cc: Rik van Riel <riel@redhat.com>, EHRHARDT@de.ibm.com, Andrea Arcangeli <andrea@qumranet.com>, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Carsten Otte wrote:
> This patch series introduces a backend for kvm to run on IBM System z
> machines that uses the mainframe's sie virtualization capability. This
> work runs 64bit guests on z800/z890/z900/z990/z9/z10 class machines with
> a 64bit linux host. Userspace will follow once we're done brushing it
> over.
>   

I'm slightly worried about the changes to non arch code.  Perhaps Andrea 
or Rik can look over the mm/ changes and ack?

Other than that, and the few minor comments that popped up, this (very 
nice) patchset will be very easy to merge.  IIRC you mentioned it is 
possible for me to get an s390 account; this will be very useful in 
avoiding breaking this port, as happens quite often with ppc and ia64.  
I'd like to be able to do both build and run testing.

-- 
Any sufficiently difficult bug is indistinguishable from a feature.

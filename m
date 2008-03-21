From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC/PATCH 15/15] guest: virtio device support, and kvm hypercalls
Date: Fri, 21 Mar 2008 12:44:27 +0200
Message-ID: <47E3918B.2040101@qumranet.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030328.6690.66.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206030328.6690.66.camel@cotte.boeblingen.de.ibm.com>
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
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Carsten Otte wrote:
> Currently we dont have PCI on s390. Making virtio_pci usable for s390 seems
> more complicated that providing an own stub. This virtio stub is similar to
> the lguest one, the memory for the descriptors and the device detection is made
> via additional mapped memory on top of the guest storage. We use an external
> interrupt with extint code 1237 for host->guest notification. 
>   

So, sanity won in the end.

-- 
Any sufficiently difficult bug is indistinguishable from a feature.

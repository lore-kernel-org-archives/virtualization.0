From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] virtio_blk: Dont waste major numbers
Date: Thu, 20 Mar 2008 10:36:53 -0700
Message-ID: <47E2A0B5.8090707__8476.22407968647$1206034951$gmane$org@zytor.com>
References: <200801311553.53653.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801311553.53653.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger wrote:
> Rusty,
> 
> currently virtio_blk uses one major number per device. While this works
> quite well on most systems it is wasteful and will exhaust major numbers
> on larger installations.
> 
> This patch allocates a major number on init and will use 16 minor numbers
> for each disk. That will allow ~64k virtio_blk disks.
> 

Would it be too much to allow 64 minors (63 partitions)?  I have run out 
of 16, myself, but never 64.

	-hpa

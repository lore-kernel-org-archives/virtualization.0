From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 2/2] vhost_net: a kernel-level virtio server
Date: Thu, 13 Aug 2009 18:37:21 +0300
Message-ID: <4A843331.1020402__37362.6746972606$1250177899$gmane$org@redhat.com>
References: <cover.1249930169.git.mst@redhat.com>
	<200908131548.35199.arnd@arndb.de>
	<20090813144129.GB5080@redhat.com>
	<200908131653.47029.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200908131653.47029.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/13/2009 05:53 PM, Arnd Bergmann wrote:
> On Thursday 13 August 2009, Michael S. Tsirkin wrote:
>    
>> The best way to do this IMO would be to add zero copy support to raw
>> sockets, vhost will then get it basically for free.
>>      
>
> Yes, that would be nice. I wonder if that could lead to security
> problems on TX though. I guess It will only bring significant performance
> improvements if we leave the data writable in the user space or guest
> during the operation. If the user finds the right timing, it could
> modify the frame headers after they have been checked using netfilter,
> or while the frames are being consumed in the kernel (e.g. an NFS
> server running in a guest).
>    

IIRC when the kernel consumes data it linearizes the skb.  We just need 
to make sure all the zerocopy data is in the nonlinear part, and the 
kernel will copy if/when it needs to access packet data.

-- 
error compiling committee.c: too many arguments to function

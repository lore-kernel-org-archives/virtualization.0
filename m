From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [Virtio-for-kvm] [PATCH 7/7] userspace virtio
Date: Wed, 02 Jan 2008 19:22:27 +0200
Message-ID: <477BC853.405__28014.2916054048$1199294776$gmane$org@qumranet.com>
References: <476BD1A9.2040701@qumranet.com> <477BB5D2.6010304@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <477BB5D2.6010304@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, dor.laor@qumranet.com, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> I think we should hold off on this sort of patch at first.  I know it 
> improves performance, but it's very hack-ish.  I have a similar patch[1] 
> that improves performance more but is even more hack-ish.
>
> I think we have to approach this by not special cases virtio-net to know 
> about the tap fd, but to figure out the interface that virtio-net would 
> need to be efficient, and then refactor the net interface to look like 
> that.  Then we can still support user, pcap, and the other network 
> transports.
>
> [1] http://hg.codemonkey.ws/qemu-virtio/file/75cefe566cea/aio-net.diff
>   

While you are right in principle, high performance networking is long 
overdue in kvm so I applied that patch.  Once a mega async dma framework 
is added to qemu, we'll just revert that patch prior to adding the glue 
to said framework.

-- 
error compiling committee.c: too many arguments to function

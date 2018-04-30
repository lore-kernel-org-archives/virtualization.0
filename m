From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v9 1/4] virtio_net: Introduce
	VIRTIO_NET_F_STANDBY feature bit
Date: Mon, 30 Apr 2018 09:03:40 +0200
Message-ID: <20180430070340.GF23854@nanopsycho.orion>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
	<1524848820-42258-2-git-send-email-sridhar.samudrala@intel.com>
	<20180428075027.GI5632@nanopsycho.orion>
	<9826909e-d6cd-a0a3-142f-6f7f8cf2b5ce@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9826909e-d6cd-a0a3-142f-6f7f8cf2b5ce@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Mon, Apr 30, 2018 at 04:47:03AM CEST, sridhar.samudrala@intel.com wrote:
>On 4/28/2018 12:50 AM, Jiri Pirko wrote:
>> Fri, Apr 27, 2018 at 07:06:57PM CEST,sridhar.samudrala@intel.com  wrote:
>> > This feature bit can be used by hypervisor to indicate virtio_net device to
>> > act as a standby for another device with the same MAC address.
>> > 
>> > VIRTIO_NET_F_STANDBY is defined as bit 62 as it is a device feature bit.
>> > 
>> > Signed-off-by: Sridhar Samudrala<sridhar.samudrala@intel.com>
>> > ---
>> > drivers/net/virtio_net.c        | 2 +-
>> > include/uapi/linux/virtio_net.h | 3 +++
>> > 2 files changed, 4 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> > index 3b5991734118..51a085b1a242 100644
>> > --- a/drivers/net/virtio_net.c
>> > +++ b/drivers/net/virtio_net.c
>> > @@ -2999,7 +2999,7 @@ static struct virtio_device_id id_table[] = {
>> > 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
>> > 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
>> > 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
>> > -	VIRTIO_NET_F_SPEED_DUPLEX
>> > +	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY
>> This is not part of current qemu master (head 6f0c4706b35dead265509115ddbd2a8d1af516c1)
>> Were I can find the qemu code?
>> 
>> Also, I think it makes sense to push HW (qemu HW in this case) first
>> and only then the driver.
>
>I had sent qemu patch with a couple of earlier versions of this patchset.
>Will include it when i send out v10.

The point was, don't you want to push it to qemu first? Did you at least
send RFC to qemu?

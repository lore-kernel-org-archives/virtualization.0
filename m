From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: [PATCH net-next v9 1/4] virtio_net: Introduce
	VIRTIO_NET_F_STANDBY feature bit
Date: Sun, 29 Apr 2018 19:47:03 -0700
Message-ID: <9826909e-d6cd-a0a3-142f-6f7f8cf2b5ce__9194.96858628026$1525056326$gmane$org@intel.com>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
	<1524848820-42258-2-git-send-email-sridhar.samudrala@intel.com>
	<20180428075027.GI5632@nanopsycho.orion>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3762895747598688172=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180428075027.GI5632@nanopsycho.orion>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiri Pirko <jiri@resnulli.us>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============3762895747598688172==
Content-Type: multipart/alternative;
 boundary="------------964F2933D3EC1565ECA96A01"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------964F2933D3EC1565ECA96A01
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/2018 12:50 AM, Jiri Pirko wrote:
> Fri, Apr 27, 2018 at 07:06:57PM CEST,sridhar.samudrala@intel.com  wrote:
>> This feature bit can be used by hypervisor to indicate virtio_net device to
>> act as a standby for another device with the same MAC address.
>>
>> VIRTIO_NET_F_STANDBY is defined as bit 62 as it is a device feature bit.
>>
>> Signed-off-by: Sridhar Samudrala<sridhar.samudrala@intel.com>
>> ---
>> drivers/net/virtio_net.c        | 2 +-
>> include/uapi/linux/virtio_net.h | 3 +++
>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 3b5991734118..51a085b1a242 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2999,7 +2999,7 @@ static struct virtio_device_id id_table[] = {
>> 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
>> 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
>> 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
>> -	VIRTIO_NET_F_SPEED_DUPLEX
>> +	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY
> This is not part of current qemu master (head 6f0c4706b35dead265509115ddbd2a8d1af516c1)
> Were I can find the qemu code?
>
> Also, I think it makes sense to push HW (qemu HW in this case) first
> and only then the driver.

I had sent qemu patch with a couple of earlier versions of this patchset.
Will include it when i send out v10.



--------------964F2933D3EC1565ECA96A01
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 4/28/2018 12:50 AM, Jiri Pirko wrote:<br>
    <blockquote type="cite"
      cite="mid:20180428075027.GI5632@nanopsycho.orion">
      <pre wrap="">Fri, Apr 27, 2018 at 07:06:57PM CEST, <a class="moz-txt-link-abbreviated" href="mailto:sridhar.samudrala@intel.com">sridhar.samudrala@intel.com</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">This feature bit can be used by hypervisor to indicate virtio_net device to
act as a standby for another device with the same MAC address.

VIRTIO_NET_F_STANDBY is defined as bit 62 as it is a device feature bit.

Signed-off-by: Sridhar Samudrala <a class="moz-txt-link-rfc2396E" href="mailto:sridhar.samudrala@intel.com">&lt;sridhar.samudrala@intel.com&gt;</a>
---
drivers/net/virtio_net.c        | 2 +-
include/uapi/linux/virtio_net.h | 3 +++
2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3b5991734118..51a085b1a242 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2999,7 +2999,7 @@ static struct virtio_device_id id_table[] = {
	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
	VIRTIO_NET_F_CTRL_MAC_ADDR, \
	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
-	VIRTIO_NET_F_SPEED_DUPLEX
+	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY
</pre>
      </blockquote>
      <pre wrap="">
This is not part of current qemu master (head 6f0c4706b35dead265509115ddbd2a8d1af516c1)
Were I can find the qemu code?

Also, I think it makes sense to push HW (qemu HW in this case) first
and only then the driver.</pre>
    </blockquote>
    <br>
    <pre>I had sent qemu patch with a couple of earlier versions of this patchset.
Will include it when i send out v10.</pre>
    <br>
  </body>
</html>

--------------964F2933D3EC1565ECA96A01--

--===============3762895747598688172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3762895747598688172==--

From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: [PATCH net-next v9 2/4] net: Introduce generic failover module
Date: Sun, 29 Apr 2018 19:47:54 -0700
Message-ID: <3d481b29-896d-6d2f-0822-85c3077e8b4f__11079.7985377305$1525056376$gmane$org@intel.com>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
	<1524848820-42258-3-git-send-email-sridhar.samudrala@intel.com>
	<20180428081542.GJ5632@nanopsycho.orion>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5188251471284607062=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180428081542.GJ5632@nanopsycho.orion>
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
--===============5188251471284607062==
Content-Type: multipart/alternative;
 boundary="------------8D4AB5F7B80B2EED5C9D0607"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8D4AB5F7B80B2EED5C9D0607
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/2018 1:15 AM, Jiri Pirko wrote:
> Fri, Apr 27, 2018 at 07:06:58PM CEST,sridhar.samudrala@intel.com  wrote:
>> This provides a generic interface for paravirtual drivers to listen
>> for netdev register/unregister/link change events from pci ethernet
>> devices with the same MAC and takeover their datapath. The notifier and
>> event handling code is based on the existing netvsc implementation.
>>
>> It exposes 2 sets of interfaces to the paravirtual drivers.
>> 1. For paravirtual drivers like virtio_net that use 3 netdev model, the
>>    the failover module provides interfaces to create/destroy additional
>>    master netdev and all the slave events are managed internally.
>>         net_failover_create()
>>         net_failover_destroy()
>>    A failover netdev is created that acts a master device and controls 2
>>    slave devices. The original virtio_net netdev is registered as 'standby'
>>    netdev and a passthru/vf device with the same MAC gets registered as
>>    'primary' netdev. Both 'standby' and 'primary' netdevs are associated
>>    with the same 'pci' device.  The user accesses the network interface via
> 'standby' and 'primary' netdevs are not associated with the same 'pci'
> device.
> "Primary" is the VF netdevice and "standby" is virtio_net. Each
> associated with different pci device.

I meant to say that 'standby' and 'failover' netdevs are associated with
the same 'pci' device. will fix it in v10.


>
>>    'failover' netdev. The 'failover' netdev chooses 'primary' netdev as
>>    default for transmits when it is available with link up and running.
>> 2. For existing netvsc driver that uses 2 netdev model, no master netdev
>>    is created. The paravirtual driver registers each instance of netvsc
>>    as a 'failover' netdev  along with a set of ops to manage the slave
>>    events. There is no 'standby' netdev in this model. A passthru/vf device
>>    with the same MAC gets registered as 'primary' netdev.
>>         net_failover_register()
>>         net_failover_unregister()
> [...]


--------------8D4AB5F7B80B2EED5C9D0607
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 4/28/2018 1:15 AM, Jiri Pirko wrote:<br>
    <blockquote type="cite"
      cite="mid:20180428081542.GJ5632@nanopsycho.orion">
      <pre wrap="">Fri, Apr 27, 2018 at 07:06:58PM CEST, <a class="moz-txt-link-abbreviated" href="mailto:sridhar.samudrala@intel.com">sridhar.samudrala@intel.com</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">This provides a generic interface for paravirtual drivers to listen
for netdev register/unregister/link change events from pci ethernet
devices with the same MAC and takeover their datapath. The notifier and
event handling code is based on the existing netvsc implementation.

It exposes 2 sets of interfaces to the paravirtual drivers.
1. For paravirtual drivers like virtio_net that use 3 netdev model, the
  the failover module provides interfaces to create/destroy additional
  master netdev and all the slave events are managed internally.
       net_failover_create()
       net_failover_destroy()
  A failover netdev is created that acts a master device and controls 2
  slave devices. The original virtio_net netdev is registered as 'standby'
  netdev and a passthru/vf device with the same MAC gets registered as
  'primary' netdev. Both 'standby' and 'primary' netdevs are associated
  with the same 'pci' device.  The user accesses the network interface via
</pre>
      </blockquote>
      <pre wrap="">'standby' and 'primary' netdevs are not associated with the same 'pci'
device.
"Primary" is the VF netdevice and "standby" is virtio_net. Each
associated with different pci device.</pre>
    </blockquote>
    <br>
    <pre>I meant to say that 'standby' and 'failover' netdevs are associated with
the same 'pci' device. will fix it in v10.</pre>
    <br>
    <blockquote type="cite"
      cite="mid:20180428081542.GJ5632@nanopsycho.orion">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">  'failover' netdev. The 'failover' netdev chooses 'primary' netdev as
  default for transmits when it is available with link up and running.
2. For existing netvsc driver that uses 2 netdev model, no master netdev
  is created. The paravirtual driver registers each instance of netvsc
  as a 'failover' netdev  along with a set of ops to manage the slave
  events. There is no 'standby' netdev in this model. A passthru/vf device
  with the same MAC gets registered as 'primary' netdev.
       net_failover_register()
       net_failover_unregister()
</pre>
      </blockquote>
      <pre wrap="">[...]
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------8D4AB5F7B80B2EED5C9D0607--

--===============5188251471284607062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5188251471284607062==--

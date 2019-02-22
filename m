From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
	PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to
	use the bypass framework)
Date: Thu, 21 Feb 2019 23:00:04 -0800
Message-ID: <91d4cbb1-be7a-b53c-6b2a-99bef07e7c53__9156.46033115394$1550819140$gmane$org@intel.com>
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
	<1523386790-12396-5-git-send-email-sridhar.samudrala@intel.com>
	<20180410142608.50f15b45@xeon-e3> <20180411075334.GK2028@nanopsycho>
	<CADGSJ214RJV_zWVBGv0Ydo=CJj6WESTYAH=PpaYLFHdtWVrm3g@mail.gmail.com>
	<20190221203808-mutt-send-email-mst@kernel.org>
	<581e4399-3969-aecd-e923-03bbc0880733@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3960901401281411382=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <581e4399-3969-aecd-e923-03bbc0880733@oracle.com>
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
To: si-wei liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Siwei Liu <loseweigh@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============3960901401281411382==
Content-Type: multipart/alternative;
 boundary="------------3DC89C74F2F5950B3AA5C02B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------3DC89C74F2F5950B3AA5C02B
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit


On 2/21/2019 7:33 PM, si-wei liu wrote:
>
>
> On 2/21/2019 5:39 PM, Michael S. Tsirkin wrote:
>> On Thu, Feb 21, 2019 at 05:14:44PM -0800, Siwei Liu wrote:
>>> Sorry for replying to this ancient thread. There was some remaining
>>> issue that I don't think the initial net_failover patch got addressed
>>> cleanly, see:
>>>
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1815268
>>>
>>> The renaming of 'eth0' to 'ens4' fails because the udev userspace was
>>> not specifically writtten for such kernel automatic enslavement.
>>> Specifically, if it is a bond or team, the slave would typically get
>>> renamed *before* virtual device gets created, that's what udev can
>>> control (without getting netdev opened early by the other part of
>>> kernel) and other userspace components for e.g. initramfs,
>>> init-scripts can coordinate well in between. The in-kernel
>>> auto-enslavement of net_failover breaks this userspace convention,
>>> which don't provides a solution if user care about consistent naming
>>> on the slave netdevs specifically.
>>>
>>> Previously this issue had been specifically called out when IFF_HIDDEN
>>> and the 1-netdev was proposed, but no one gives out a solution to this
>>> problem ever since. Please share your mind how to proceed and solve
>>> this userspace issue if netdev does not welcome a 1-netdev model.
>> Above says:
>>
>>     there's no motivation in the systemd/udevd community at
>>     this point to refactor the rename logic and make it work well with
>>     3-netdev.
>>
>> What would the fix be? Skip slave devices?
>>
> There's nothing user can get if just skipping slave devices - the name 
> is still unchanged and unpredictable e.g. eth0, or eth1 the next 
> reboot, while the rest may conform to the naming scheme (ens3 and 
> such). There's no way one can fix this in userspace alone - when the 
> failover is created the enslaved netdev was opened by the kernel 
> earlier than the userspace is made aware of, and there's no 
> negotiation protocol for kernel to know when userspace has done 
> initial renaming of the interface. I would expect netdev list should 
> at least provide the direction in general for how this can be solved...
>
Is there an issue if slave device names are not predictable? The user/admin scripts are expected
to only work with the master failover device.
Moreover, you were suggesting hiding the lower slave devices anyway. There was some discussion
about moving them to a hidden network namespace so that they are not visible from the default namespace.
I looked into this sometime back, but did not find the right kernel api to create a network namespace within
kernel. If so, we could use this mechanism to simulate a 1-netdev model.


> -Siwei
>
>

--------------3DC89C74F2F5950B3AA5C02B
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/21/2019 7:33 PM, si-wei liu wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:581e4399-3969-aecd-e923-03bbc0880733@oracle.com">
      <br>
      <br>
      On 2/21/2019 5:39 PM, Michael S. Tsirkin wrote:
      <br>
      <blockquote type="cite">On Thu, Feb 21, 2019 at 05:14:44PM -0800,
        Siwei Liu wrote:
        <br>
        <blockquote type="cite">Sorry for replying to this ancient
          thread. There was some remaining
          <br>
          issue that I don't think the initial net_failover patch got
          addressed
          <br>
          cleanly, see:
          <br>
          <br>
          <a class="moz-txt-link-freetext" href="https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1815268">https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1815268</a>
          <br>
          <br>
          The renaming of 'eth0' to 'ens4' fails because the udev
          userspace was
          <br>
          not specifically writtten for such kernel automatic
          enslavement.
          <br>
          Specifically, if it is a bond or team, the slave would
          typically get
          <br>
          renamed *before* virtual device gets created, that's what udev
          can
          <br>
          control (without getting netdev opened early by the other part
          of
          <br>
          kernel) and other userspace components for e.g. initramfs,
          <br>
          init-scripts can coordinate well in between. The in-kernel
          <br>
          auto-enslavement of net_failover breaks this userspace
          convention,
          <br>
          which don't provides a solution if user care about consistent
          naming
          <br>
          on the slave netdevs specifically.
          <br>
          <br>
          Previously this issue had been specifically called out when
          IFF_HIDDEN
          <br>
          and the 1-netdev was proposed, but no one gives out a solution
          to this
          <br>
          problem ever since. Please share your mind how to proceed and
          solve
          <br>
          this userspace issue if netdev does not welcome a 1-netdev
          model.
          <br>
        </blockquote>
        Above says:
        <br>
        <br>
            there's no motivation in the systemd/udevd community at
        <br>
            this point to refactor the rename logic and make it work
        well with
        <br>
            3-netdev.
        <br>
        <br>
        What would the fix be? Skip slave devices?
        <br>
        <br>
      </blockquote>
      There's nothing user can get if just skipping slave devices - the
      name is still unchanged and unpredictable e.g. eth0, or eth1 the
      next reboot, while the rest may conform to the naming scheme (ens3
      and such). There's no way one can fix this in userspace alone -
      when the failover is created the enslaved netdev was opened by the
      kernel earlier than the userspace is made aware of, and there's no
      negotiation protocol for kernel to know when userspace has done
      initial renaming of the interface. I would expect netdev list
      should at least provide the direction in general for how this can
      be solved...
      <br>
      <br>
    </blockquote>
    <pre>Is there an issue if slave device names are not predictable? The user/admin scripts are expected
to only work with the master failover device.
Moreover, you were suggesting hiding the lower slave devices anyway. There was some discussion
about moving them to a hidden network namespace so that they are not visible from the default namespace.
I looked into this sometime back, but did not find the right kernel api to create a network namespace within
kernel. If so, we could use this mechanism to simulate a 1-netdev model.
</pre>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:581e4399-3969-aecd-e923-03bbc0880733@oracle.com">-Siwei
      <br>
      <br>
      <br>
    </blockquote>
  </body>
</html>

--------------3DC89C74F2F5950B3AA5C02B--

--===============3960901401281411382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3960901401281411382==--

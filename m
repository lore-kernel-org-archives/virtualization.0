From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: [RFC PATCH net-next] failover: allow name change on IFF_UP slave
	interfaces
Date: Wed, 6 Mar 2019 13:36:27 -0800
Message-ID: <cb71d2c4-c2b9-28df-1882-154ee3b9b9b6@intel.com>
References: <1551747059-11831-1-git-send-email-si-wei.liu@oracle.com>
	<20190306120430.GA2819@nanopsycho>
	<7d1e79f6-01ff-413d-dac0-ee34258aafec@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6688099637331711416=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7d1e79f6-01ff-413d-dac0-ee34258aafec@oracle.com>
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
To: si-wei liu <si-wei.liu@oracle.com>, Jiri Pirko <jiri@resnulli.us>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, boris.ostrovsky@oracle.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============6688099637331711416==
Content-Type: multipart/alternative;
 boundary="------------65923323CE40D3D516B72AF9"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------65923323CE40D3D516B72AF9
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit


On 3/6/2019 1:26 PM, si-wei liu wrote:
>
>
>
> On 3/6/2019 4:04 AM, Jiri Pirko wrote:
>>> --- a/net/core/failover.c
>>> +++ b/net/core/failover.c
>>> @@ -16,6 +16,11 @@
>>>
>>> static LIST_HEAD(failover_list);
>>> static DEFINE_SPINLOCK(failover_lock);
>>> +static bool slave_rename_ok = true;
>>> +
>>> +module_param(slave_rename_ok, bool, (S_IRUGO | S_IWUSR));
>>> +MODULE_PARM_DESC(slave_rename_ok,
>>> +		 "If set allow renaming the slave when failover master is up");
>> No module parameters please. If you need to set something do it using
>> rtnl_link_ops. Thanks.
>>
> I understand what you ask for, but without module parameters userspace 
> don't work. During boot (dracut) the virtio netdev gets enslaved 
> earlier than when userspace comes up, so failover has to determine the 
> setting during initialization/creation. This config is not dynamic, at 
> least for the life cycle of a particular failover link it shouldn't be 
> changed. Without module parameter, how does the userspace specify this 
> value during kernel initialization?
>
Can we enable this by default and not make it configurable via module 
parameter?
Is there any  usecase where someone expects rename to fail with failover 
slaves?

--------------65923323CE40D3D516B72AF9
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
    <div class="moz-cite-prefix">On 3/6/2019 1:26 PM, si-wei liu wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:7d1e79f6-01ff-413d-dac0-ee34258aafec@oracle.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <p><br>
      </p>
      <br>
      <div class="moz-cite-prefix">On 3/6/2019 4:04 AM, Jiri Pirko
        wrote:<br>
      </div>
      <blockquote cite="mid:20190306120430.GA2819@nanopsycho"
        type="cite">
        <blockquote type="cite" style="color: #000000;">
          <pre wrap="">--- a/net/core/failover.c
+++ b/net/core/failover.c
@@ -16,6 +16,11 @@

static LIST_HEAD(failover_list);
static DEFINE_SPINLOCK(failover_lock);
+static bool slave_rename_ok = true;
+
+module_param(slave_rename_ok, bool, (S_IRUGO | S_IWUSR));
+MODULE_PARM_DESC(slave_rename_ok,
+		 "If set allow renaming the slave when failover master is up");
</pre>
        </blockquote>
        <pre wrap="">No module parameters please. If you need to set something do it using
rtnl_link_ops. Thanks.

</pre>
      </blockquote>
      I understand what you ask for, but without module parameters
      userspace don't work. During boot (dracut) the virtio netdev gets
      enslaved earlier than when userspace comes up, so failover has to
      determine the setting during initialization/creation. This config
      is not dynamic, at least for the life cycle of a particular
      failover link it shouldn't be changed. Without module parameter,
      how does the userspace specify this value during kernel
      initialization? <br>
      <br>
    </blockquote>
    Can we enable this by default and not make it configurable via
    module parameter?<br>
    Is there any  usecase where someone expects rename to fail with
    failover slaves?<br>
  </body>
</html>

--------------65923323CE40D3D516B72AF9--

--===============6688099637331711416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6688099637331711416==--

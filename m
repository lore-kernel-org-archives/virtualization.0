From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [PATCH 1/6] virtio interace
Date: Sun, 23 Sep 2007 13:20:11 +0200
Message-ID: <46F64BEB.8040307__42330.5652723231$1190546643$gmane$org@qumranet.com>
References: <1190289808.7262.223.camel@localhost.localdomain>	
	<200709211622.22005.arnd@arndb.de>	
	<1190454934.27805.80.camel@localhost.localdomain>	
	<200709221201.33865.arnd@arndb.de>
	<1190536431.27805.109.camel@localhost.localdomain>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4692762824935710313=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190536431.27805.109.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============4692762824935710313==
Content-Type: multipart/alternative;
	boundary="------------090500040602090702090600"

This is a multi-part message in MIME format.
--------------090500040602090702090600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rusty Russell wrote:
> On Sat, 2007-09-22 at 12:01 +0200, Arnd Bergmann wrote:
>   
>> On Saturday 22 September 2007, Rusty Russell wrote:
>>     
>>> But now each virtio device has two "struct device"s, not one.   And
>>> you've made up a fictional bus to do it.
>>>
>>> Yet for PCI systems, it really is a PCI device; exposing a second bus to
>>> userspace just because we put a layer in our implementation is poor
>>> form.
>>>
>>> Perhaps this is the easiest way of doing it.  But it's still wrong.
>>>       
>> I think it's just a matter of perspective. In the model I'm advocating,
>> the PCI device is not the same as the virtio device but rather a virtio
>> host bridge, very much like USB or SATA works.
>>
>> We could easily have multiple virtio devices behind one PCI device, but
>> since virtual PCI devices are cheap, a one-to-one mapping makes sense
>> for simplicity.
>>     
>
> This is still retro-justification.  The simplest way for PCI systems to
> represent a virtio device as a PCI device; this makes life easy for any
> guest OS.
>
> I just know we're going to regret this...
> Rusty.
>
>
>   
I'm not sure what's best, maybe this can help:
With the virtio_find_driver you need to place all virtio drivers under 
the same pci device or suggest new mapping.
Using Arnd's solution (actually I implemented it for KVM before the new 
patch set) and  1-1 mapping for pci and virtio
devices makes life simpler.
Dor.


--------------090500040602090702090600
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Rusty Russell wrote:
<blockquote cite="mid:1190536431.27805.109.camel@localhost.localdomain"
 type="cite">
  <pre wrap="">On Sat, 2007-09-22 at 12:01 +0200, Arnd Bergmann wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Saturday 22 September 2007, Rusty Russell wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">But now each virtio device has two "struct device"s, not one.   And
you've made up a fictional bus to do it.

Yet for PCI systems, it really is a PCI device; exposing a second bus to
userspace just because we put a layer in our implementation is poor
form.

Perhaps this is the easiest way of doing it.  But it's still wrong.
      </pre>
    </blockquote>
    <pre wrap="">I think it's just a matter of perspective. In the model I'm advocating,
the PCI device is not the same as the virtio device but rather a virtio
host bridge, very much like USB or SATA works.

We could easily have multiple virtio devices behind one PCI device, but
since virtual PCI devices are cheap, a one-to-one mapping makes sense
for simplicity.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This is still retro-justification.  The simplest way for PCI systems to
represent a virtio device as a PCI device; this makes life easy for any
guest OS.

I just know we're going to regret this...
Rusty.


  </pre>
</blockquote>
I'm not sure what's best, maybe this can help:<br>
With the virtio_find_driver you need to place all virtio drivers under
the same pci device or suggest new mapping.<br>
Using Arnd's solution (actually I implemented it for KVM before the new
patch set) and&nbsp; 1-1 mapping for pci and virtio <br>
devices makes life simpler.<br>
Dor.<br>
<br>
</body>
</html>

--------------090500040602090702090600--

--===============4692762824935710313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============4692762824935710313==--

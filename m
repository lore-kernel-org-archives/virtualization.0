From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for generic
	guest and host communication
Date: Fri, 18 Sep 2009 13:02:13 -0500
Message-ID: <4AB3CB25.2080808__48610.8554680415$1253297019$gmane$org@codemonkey.ws>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>	<1252678386-17404-2-git-send-email-amit.shah@redhat.com>	<20090911170010.34c80f2d@linux.intel.com>	<20090911163806.GB25535@amit-x200.redhat.com>	<4AAA8838.1080106@codemonkey.ws>	<20090911173307.GB27046@amit-x200.redhat.com>	<4AAA8A56.3040707@codemonkey.ws>	<20090916112332.6bf981a5@linux.intel.com>	<4AB164A0.8000402@codemonkey.ws>
	<20090918170048.53ba8cf6@linux.intel.com>
	<4AB3C988.2040303@codemonkey.ws> <4AB3CA27.1040307@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AB3CA27.1040307@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> On 09/18/2009 10:55 AM, Anthony Liguori wrote:
>   
>> I fail to see how this is at all relevant.  This is a virtual machine,
>> we're presenting virtual hardware that behaves like a serial device. 
>> Where web servers fit in is completely beyond me.
>>
>>     
>
> s/virtio_console/virtio_serial/
>
> There is a fairly noticeable difference between a "console device" and a
> "serial device".  However, something that can be extended and exported
> to a physical serial port is definitely the latter.
>   

Indeed.  I think part of the confusion here is that virtio_console 
started as just as console and hence it used hvc.  As part of the 
current reworking, I think it makes sense to rename the driver 
virtio_serial.

Regards,

Anthony Liguori

> 	-hpa
>
>   

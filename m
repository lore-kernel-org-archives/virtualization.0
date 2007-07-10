From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Tue, 10 Jul 2007 09:06:04 +0300
Message-ID: <469321CC.3060805@qumranet.com>
References: <20070706124200.988637662@arndb.de>	
	<200707081729.58461.arnd@arndb.de> <4691076B.5050106@qumranet.com>	
	<200707082229.00810.arnd@arndb.de> <4691DA69.4060204@qumranet.com>
	<1184030276.6005.412.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184030276.6005.412.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Arnd Bergmann <arnd@arndb.de>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Mon, 2007-07-09 at 09:49 +0300, Avi Kivity wrote:
>   
>> At the very least, we need an interrupt for device hotplug.  That same
>> interrupt can be used to notify the guest about configuration changes
>> within a device ("rescan the virtbus and all who sail in her").
>>     
>
> Avi, this is overdesign; let's not try to boil the ocean or virtbus
> might sink beneath the waves and we'll be down the drain without a
> paddle.
>   

Well, I guess automatic device hotplug is a bit esoteric.  We can start
without it and only implement it if there are mass demonstrations in its
favor.  Just as long as we don't commit to anything in the ABIs.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

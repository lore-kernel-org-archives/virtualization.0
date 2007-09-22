From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 2/6] virtio_config
Date: Sat, 22 Sep 2007 15:03:33 +0200
Message-ID: <46F512A5.90506__22540.7475176782$1190466141$gmane$org@qumranet.com>
References: <1190289808.7262.223.camel@localhost.localdomain>	<1190290140.7262.228.camel@localhost.localdomain>	<1190290369.7262.231.camel@localhost.localdomain>	<46F26958.4080102@qumranet.com>
	<46F26DC7.9040001@qumranet.com>
	<1190339435.19451.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190339435.19451.23.camel@localhost.localdomain>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
>>
>> A side effect of this is that Xen drivers can no longer use virtio.
>>     
>
> I'm not so sure.
>
> We were always assuming that Xen could do state management in its virtio
> layer.  If this is not true, it implies we need hooks in the virtio
> drivers, and I don't think we've made it worse by making it translate
> xenbus config info into virtio_config.
>   

This means writing a low-level ABI in terms of a high level API.  And
while that describes virtualization fairly will, I prefer not to do this
more than strictly necessary.

However, this can be rewritten if/when Xen or VMware show interest in
porting their drivers to virtio.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 2/6] virtio_config
Date: Thu, 20 Sep 2007 14:36:40 +0200
Message-ID: <46F26958.4080102__17285.845304332$1190291917$gmane$org@qumranet.com>
References: <1190289808.7262.223.camel@localhost.localdomain>	<1190290140.7262.228.camel@localhost.localdomain>
	<1190290369.7262.231.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190290369.7262.231.camel@localhost.localdomain>
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
> Previous versions of virtio didn't commonalize probing.  For every
> driver, every virtio implementation (KVM, lguest, etc) needed an
> in-kernel stub to join their bus to the probe code.
>
> To solve this, we introduce a "virtio_config" mechanism, which is
> simply a set of [u8 type][u8 len][...data...] fields for each device.
> Some convenient wrapper functions make this fairly easy for drivers to
> unpack their configuration data themselves.
>
> This configuration data could be PCI config space, or an unrelated bus
> (eg. lguest) or manufactured by the kernel itself.  It's designed to
> be extensible: fields get marked as the device reads them so a host
> supporting some future extension can tell if the guest driver
> understood it.  This also applies to bitfields: the guest explicitly
> acks the bits it understands.
>
> There's also a simple status bitmask useful for low-level host
> analysis of what the guest is doing with the device.
>
>   

Lovely.

-- 
error compiling committee.c: too many arguments to function

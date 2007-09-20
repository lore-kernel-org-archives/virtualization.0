From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 6/6] virtio ring helper
Date: Thu, 20 Sep 2007 14:43:34 +0200
Message-ID: <46F26AF6.60904__35035.0260538564$1190292386$gmane$org@qumranet.com>
References: <1190289808.7262.223.camel@localhost.localdomain>	<1190290140.7262.228.camel@localhost.localdomain>	<1190290369.7262.231.camel@localhost.localdomain>	<1190290495.7262.235.camel@localhost.localdomain>	<1190290606.7262.239.camel@localhost.localdomain>	<1190290761.7262.242.camel@localhost.localdomain>
	<1190291234.7262.246.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190291234.7262.246.camel@localhost.localdomain>
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
> These helper routines supply most of the virtqueue_ops for hypervisors
> which want to use a ring for virtio.  Unlike the previous lguest
> implementation:
>
> 3) The page numbers are always 64 bit (PAE anyone?)
>   

32 bits of page numbers give 44 bits of physical address on x86.  That's 
16TB per guest.  Admittedly it's smaller on a VAX.

I don't like the chaining and would prefer the descriptor to refer to an 
array of page descriptors.  However I can't complain since this isn't 
common code.

-- 
error compiling committee.c: too many arguments to function

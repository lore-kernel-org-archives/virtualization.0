From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH v10 1/1] virtio_console: Add support for multiple ports
	for generic guest and host communication
Date: Fri, 06 Nov 2009 08:32:05 -0600
Message-ID: <4AF43365.2030208__31077.4161982865$1257518321$gmane$org@us.ibm.com>
References: <1257266319-24300-1-git-send-email-amit.shah@redhat.com>
	<200911060900.49923.borntraeger@de.ibm.com>	<4AF41DF0.7050002@us.ibm.com>
	<200911061512.40413.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200911061512.40413.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, virtualization@linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger wrote:
>> Fundamentally speaking, right now, virtio-console is a single stream
>> that acts as an interactive terminal.  What we're looking to add here is
>> to support multiple terminals that can be enumerated in a rationale way.
>>     
>
> Right, that is a point where I disagree. The original purpose and intent of the 
> multiple port thing was to have a generic guest/host comm channels and *NOT* to 
> have multiple console devices. Having multiple console devices is just a fall-
> out of the current implementation.
>   

This is part of what makes this series so difficult.  As a generic 
guest/host communications channel, this series does not at all meet 
reasonable expectations.  It makes no attempt to deal with things like 
live migration.  It can at best be described as a hack.

The whole thing's a mess because it's never been thought through 
properly which is probably because the actual consumer of it has not 
been released publicly.

I've always advocated that this use case would be better served as a 
_userspace_ interface that implements a protocol on top of an arbitrary 
transport.  It could be a network socket, a virtio device (even 
virtio-console unmodified), a real serial device, etc.

You can do multiplexing, connect/disconnect notification, etc. all as 
elements of a streaming protocol.  Throwing all of these channel 
semantics coupled tightly with the transport and then trying to make a 
kernel interface be what's the supported user interface is really just 
asking for trouble.

-- 
Regards,

Anthony Liguori

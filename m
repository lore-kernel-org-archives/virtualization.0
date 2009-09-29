From: Hank Janssen <hjanssen@microsoft.com>
Subject: Learning question regarding virtio and partvirt_ops
Date: Tue, 29 Sep 2009 17:55:05 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C5620E784325@TK5EX14MBXC114.redmond.corp.microsoft.com>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com>
	<20090919224430.GB9567@kroah.com>
	<1253419185.3253.21.camel@ank32.eng.vmware.com>
	<20090920074247.GA5733@elte.hu>
	<1253647845.10565.20.camel@ank32.eng.vmware.com>
	<4AB9CE66.1030504@redhat.com>
	<1254185107.13456.32.camel@ank32.eng.vmware.com>
	<20090929100831.18ece319@infradead.org>
	<1254242989.7803.11.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1254242989.7803.11.camel@ank32.eng.vmware.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



Greetings all,

I guess this is my official first port on the virtualization mailing list.

So any errors in posting and the correctness of asking questions in the present
And future are mine alone :)

I am one of the Microsoft developers responsible for Hyper-V support for Linux.

I had the pleasure of meeting Anthony Liguori and Chris Wright last week at the Linux Plumbers
Conference in Portland.

The discussion was around virtio and possibly using some virtio for the Hyper-V work.
Since I am still much a novice with virtio, I wanted to ask the general wisdom on the list.

There is also paravirt_ops, and I am trying to understand the relationship of paravirt_ops
And the kernel, virtio and the kernel and possible relation between paravirt_ops and virtio.

Is there a place somebody can point me towards that gives me a better understanding of
These two systems, how they compliment/do not compliment, are the same or are not the same.
And what is the general direction of the people on the list regarding these systems.

Why you would use one over the other, or if they can be combined in some way.

I know this might be a loaded question, but there you have it :)

Anthony and Chris can only be blamed for telling me that this is a good list to have
These discussions on. Everything else is my fault :)

Thanks,

Hank.

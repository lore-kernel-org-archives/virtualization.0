From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Help - KVM TODO_NOV2008_Sharing Memory between guests
Date: Wed, 25 Feb 2009 09:41:32 -0600
Message-ID: <49A566AC.3010208@codemonkey.ws>
References: <b20fe0330902210535p1efb68bcv282853c5f4f08f3b@mail.gmail.com>
	<49A549F1.8000901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <49A549F1.8000901@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: PICT PUNE <kvm.smartshare@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> PICT PUNE wrote:
>> In reference to the November 2008 todo list on Qumranet Website
>>
>> we are a group of college students working on this todo:
>>
>> *Add a qemu interface for sharing memory between guests. Using a pci 
>> device to expose the shared memory is probably a good starting point.
>> *
>> Can anyone suggest us some starting point or a possible approach for 
>> the same...
> 
> Write a PCI device that exposes a BAR containing RAM.  Implement the RAM 
> by mapping a shared memory segment or a file.  Write a guest driver to 
> use this shared RAM.
>

Or implement a virtio device that can advertise available shared memory 
segments.  Have guest allocate its own memory to send to host that 
becomes the shared memory segment.

Expose shared memory mappings via a virtual file system (similar to 
hugetlbfs or ramfs).

Using PCI BARs implies static shared memory mappings.  For a long 
running VM, you're likely to want to support dynamic shared memory mappings.

Also exposing a simple signaling mechanism with this too would allow for 
shared ring queues to be implemented in userspace between guests.

Regards,

Anthony Liguori

From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [virtio-dev] Zerocopy VM-to-VM networking using virtio-net
Date: Fri, 24 Apr 2015 14:22:33 +0100
Message-ID: <CAJSP0QU=0KXC3uRjFGukNvKQkSLnSOMvXpEoLgzoxD7CRSx2iA@mail.gmail.com>
References: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
	<CAA2XHbd_Wxs3O6ChSGouF3ZGH-SA0Lzw7OFVfvnuAXZmLAkZoA@mail.gmail.com>
	<CAJSP0QWtbzWwbvHYHVDJ2bccJ1wPZ0WA31bOH5UkGMhbkLF-Ng@mail.gmail.com>
	<CAA2XHbdvxTviZ-wxRVd87EuajcrOb1g=3Rafdyc5cXrzGbJMqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAA2XHbdvxTviZ-wxRVd87EuajcrOb1g=3Rafdyc5cXrzGbJMqA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Luke Gorrie <luke@snabb.co>
Cc: Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Rik van Riel <riel@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-comment@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 24, 2015 at 1:17 PM, Luke Gorrie <luke@snabb.co> wrote:
> On 24 April 2015 at 11:47, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>> My concern is the overhead of the vhost_net component copying
>> descriptors between NICs.
>
>
> I see. So you would not have to reserve CPU resources for vswitches. Instead
> you would give all cores to the VMs and they would pay for their own
> networking. This would be especially appealing in the extreme case where all
> networking is "Layer 1" connectivity between local virtual machines.
>
> This would make VM<->VM links different to VM<->network links. I suppose
> that when you created VMs you would need to be conscious of whether or not
> you are placing them on the same host or NUMA node so that you can predict
> what network performance will be available.

The motivation for making VM-to-VM fast is that while software
switches on the host are efficient today (thanks to vhost-user), there
is no efficient solution if the software switch is a VM.

Have you had requests to run SnabbSwitch in a VM instead of on the
host?  For example, if someone wants to deploy it in a cloud
environment they will not be allowed to run arbitrary software on the
host.

Stefan

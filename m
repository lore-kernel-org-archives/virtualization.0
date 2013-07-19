From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: is kexec on Xen domU possible?
Date: Fri, 19 Jul 2013 13:58:05 -0700
Message-ID: <51E9A85D.2060206@zytor.com>
References: <20130719020603.GA22932@kroah.com>
	<20130719131819.GC11233@debian70-amd64.local.net-space.pl>
	<20130719151243.GA15488@kroah.com>
	<20130719183235.GA12267@debian70-amd64.local.net-space.pl>
	<20130719191449.GA1882@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130719191449.GA1882@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel Kiper <daniel.kiper@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Eric Biederman <ebiederm@xmission.com>, Brandon Philips <brandon@ifup.org>
List-Id: virtualization@lists.linuxfoundation.org

On 07/19/2013 12:14 PM, Greg KH wrote:
>>
>>> The errors that the kexec tools seem to run into is finding the memory
>>> to place the new kernel into, is that just an issue that PV guests
>>> aren't given enough kernel memory in which to replicate themselves from
>>> dom0?
>>
>> There are a lot of differences between baremetal machines and PV guests.
>> For example you are not able to do identity mapping per se in PV guests.
>> Arguments to new kernel are passed in completely different way. etc.
> 
> Ok, thanks for confirming that it is possible, but doesn't currently
> work for pv guests.
> 

Also, in any virtualized environment the hypervisor can do a better job
for things like kdump, simply because it can provide two things that are
otherwise hard to do:

1. a known-good system state;
2. a known-clean kdump image.

As such, I do encourage the virtualization people to (also) develop
hypervisor-*aware* solutions for these kinds of things.

	-hpa

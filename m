From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: is kexec on Xen domU possible?
Date: Mon, 22 Jul 2013 11:24:46 -0700
Message-ID: <51ED78EE.9020903@zytor.com>
References: <20130719020603.GA22932@kroah.com>
	<20130719131819.GC11233@debian70-amd64.local.net-space.pl>
	<20130719151243.GA15488@kroah.com>
	<20130719183235.GA12267@debian70-amd64.local.net-space.pl>
	<20130719191449.GA1882@kroah.com> <51E9A85D.2060206@zytor.com>
	<20130722170307.GB14451@debian70-amd64.local.net-space.pl>
	<87wqoise9d.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87wqoise9d.fsf@xmission.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg KH <gregkh@linuxfoundation.org>, Daniel Kiper <daniel.kiper@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Brandon Philips <brandon@ifup.org>
List-Id: virtualization@lists.linuxfoundation.org

On 07/22/2013 10:20 AM, Eric W. Biederman wrote:
>>>
>>> Also, in any virtualized environment the hypervisor can do a better job
>>> for things like kdump, simply because it can provide two things that are
>>> otherwise hard to do:
>>>
>>> 1. a known-good system state;
>>> 2. a known-clean kdump image.
>>>
>>> As such, I do encourage the virtualization people to (also) develop
>>> hypervisor-*aware* solutions for these kinds of things.
>>
>> In general I agree but if you could not change hypervisor
>> and/or dom0 (e.g. you are using cloud providers which are
>> stick to old versions of Xen) then you have no choice.
> 
> Which tends to be where kexec on panic comes in most cases.  Getting
> platform vendors to do something sane tends to be a multi-year political
> effort of dubious worth while just solving the problem locally actually
> gets the problem solved for those who care.
> 

It should not be a "one or the other" issue.

	-hpa

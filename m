From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 14:45:30 -0700
Message-ID: <46CCAE7A.7000206@vmware.com>
References: <46CBC842.4070100@vmware.com> <20070822102217.GE2642@bingen.suse.de> <46CC68D9.5060200@vmware.com> <20070822175918.GB8058@bingen.suse.de> <46CC6D63.2010204@vmware.com> <20070822194632.GD8058@bingen.suse.de> <46CC9FF2.3040406@vmware.com> <20070822220451.GJ8058@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934063AbXHVVuw@vger.kernel.org>
In-Reply-To: <20070822220451.GJ8058@bingen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Avi Kivity <avi@qumranet.com>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>
>> We might benefit from it, but would the 
>> BusLogic driver?  It sets a nasty precedent for maintenance as different 
>> hypervisors and emulators hack up different drivers for their own 
>> performance.
>>     
>
> I still think it's preferable to change some drivers than everybody.
>
> AFAIK BusLogic as real hardware is pretty much dead anyways,
> so you're probably the only primary user of it anyways.
> Go wild on it!
>   

It is looking juicy.  Maybe another day.

Zach

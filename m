From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH 1/6] staging: hv: Fixed bounce kmap problem by using
 correct index
Date: Wed, 4 Aug 2010 04:35:06 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56223FE8B19@TK5EX14MBXC114.redmond.corp.microsoft.com>
References: <8AFC7968D54FB448A30D8F38F259C56223FD0D21@TK5EX14MBXC114.redmond.corp.microsoft.com>
 <20100803173732.GA1455@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100803173732.GA1455@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org


And then Greg spoke:
>>On Tue, Aug 03, 2010 at 05:31:51PM +0000, Hank Janssen wrote:
>> From: Hank Janssen <hjanssen@microsoft.com>
>> 
> >Fixed bounce offset kmap problem by using correct index
>
>Is this a bugfix that needs to go to previous kernel releases?  If so, which ones?  What is the symptom of the problem here?

Yes, this should be backported to all stable kernel releases that have the Hyper-V drivers In them.  

The symptom of the problem is that in some NAS appliances this problem represents
Itself by a unresponsive VM under a load with many clients writing small files.

I actually goofed up in my previous code and used an incorrect index number
For this part of the code. It should have shown up in more situations than what
I have seen oddly enough.

Hank.

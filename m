From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Sat, 19 Sep 2009 12:31:11 +0530
Message-ID: <20090919070111.GA5582__6869.06795385784$1253343767$gmane$org@amit-x200.redhat.com>
References: <1252678386-17404-2-git-send-email-amit.shah@redhat.com>
	<20090911170010.34c80f2d@linux.intel.com>
	<20090911163806.GB25535@amit-x200.redhat.com>
	<4AAA8838.1080106@codemonkey.ws>
	<20090911173307.GB27046@amit-x200.redhat.com>
	<4AAA8A56.3040707@codemonkey.ws>
	<20090916112332.6bf981a5@linux.intel.com>
	<4AB164A0.8000402@codemonkey.ws>
	<20090918170048.53ba8cf6@linux.intel.com>
	<4AB3C988.2040303@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AB3C988.2040303@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) Sep 18 2009 [12:55:20], Anthony Liguori wrote:
>> So you need a tiny kernel side driver to unpack it into a meaningful
>> fs, or just a user-user channel with a daemon each end and a protocol
>> over it - nothing kernel in that.
>>   
>
> I think there's some confusion over what this driver actually is.
>
> From my perspective, this is a paravirtual serial device and nothing  
> more.  All the discussion of things like guest copy/paste support is a  
> bit silly.  This is the wrong way to approach that sort of thing because  
> it's not something that belongs in the kernel at all.  Furthermore, the  
> current proposal doesn't handle anything like save/restore which is  
> needed for live migration.

You're mistaken. If you see the patches, I'm only providing a transport
in the kernel. No intelligence in the kernel as to what kind of data
actually flows through. The save/restore support has to come from
userspace, in this case qemu. And that support is very much present.

		Amit
-- 
http://log.amitshah.net/

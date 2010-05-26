From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH 1/1] staging: hv: Fix race condition on IC channel
	initialization (modified)
Date: Wed, 26 May 2010 22:03:20 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C5621B02619C@TK5EX14MBXC116.redmond.corp.microsoft.com>
References: <1FB5E1D5CA062146B38059374562DF7266B8C4AC@TK5EX14MBXC128.redmond.corp.microsoft.com>
	<20100526205134.GC7343@suse.de>
	<1FB5E1D5CA062146B38059374562DF7266B8C72B@TK5EX14MBXC128.redmond.corp.microsoft.com>
	<20100526214842.GA27908@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20100526214842.GA27908@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Greg KH <gregkh@suse.de>, Haiyang Zhang <haiyangz@microsoft.com>
Cc: "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Wednesday, May 26, 2010 2:49 PM
> To: Haiyang Zhang
> Cc: 'linux-kernel@vger.kernel.org'; 'devel@driverdev.osuosl.org'; 
> 'virtualization@lists.osdl.org'; Hank Janssen
> Subject: Re: [PATCH 1/1] staging: hv: Fix race condition on IC channel 
> initialization (modified)
> On Wed, May 26, 2010 at 09:25:31PM +0000, Haiyang Zhang wrote:
>>> From: Greg KH [mailto:gregkh@suse.de]
>>> What's with the "ic_" naming scheme here?  It should be "hv_"
> right?
>> 
>> IC stands for "integration components", such as Shutdown, Timesync,
>> Heartbeat, etc.
> 
> Yes, I know what it stands for, but the rest of the world doesn't :)

Marketing in the their infinite wisdom decided that going forward they 
should be called Linux Integration Service so IS. 

Sigh..............

We will change it to hv_  :)

Hank.

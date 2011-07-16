From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 097/117] Staging: hv: storvsc: Add code to handle IDE
	devices using the storvsc driver
Date: Sat, 16 Jul 2011 14:27:23 -0400
Message-ID: <20110716182723.GA21943@infradead.org>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-97-git-send-email-kys@microsoft.com>
	<20110716020447.GB7199@infradead.org>
	<6E21E5352C11B742B20C142EB499E0480817A4DA@TK5EX14MBXC124.redmond.corp.microsoft.com>
	<1310821299.1976.2.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1310821299.1976.2.camel@lappy>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jul 16, 2011 at 04:01:39PM +0300, Sasha Levin wrote:
> Is think that what Christoph meant was simplifying it to:
> 
> 	if (dev_is_ide)
> 		storvsc_get_ide_info(device, &target, &path);
> 	
> 	host_dev->path = device_info.path_id;
> 	host_dev->target = device_info.target_id;

Indeed.  In addition path is unused and target is only used in the
second dev_is_ide conditional, so both the call and the target and path
variables can be moved into that one to further simplify the function.

But I'm fine with delaying that cleanup to a follow on patch so that
we can make progress in getting this pile merged.

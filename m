From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 34/40] Staging: hv: storvsc: Add the contents of
	hyperv_storage.h to storvsc_drv.c
Date: Thu, 30 Jun 2011 20:13:51 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0480816C297@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-34-git-send-email-kys@microsoft.com>
	<20110630194530.GE22707@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110630194530.GE22707@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Thursday, June 30, 2011 3:46 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang;
> Abhishek Kane (Mindtree Consulting PVT LTD); Hank Janssen
> Subject: Re: [PATCH 34/40] Staging: hv: storvsc: Add the contents of
> hyperv_storage.h to storvsc_drv.c
> 
> On Wed, Jun 29, 2011 at 07:39:31AM -0700, K. Y. Srinivasan wrote:
> > Add the contents of hyperv_storage.h to storvsc_drv.c and cleanup
> storvsc_drv.c.n
> 
> I'd at least leave the first half of the header that defines the
> protocol around.

I only got rid of the block comment at the start of hyperv_storage.h
and consolidated the include files. Nothing of substance was deleted.

Regards,

K. Y

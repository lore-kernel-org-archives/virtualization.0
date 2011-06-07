From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 24/49] Staging: hv: vmbus: Get rid of the unused wrapper
 - vmbus_onchannel_event()
Date: Tue, 7 Jun 2011 14:59:32 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0480813D861@TK5EX14MBXC122.redmond.corp.microsoft.com>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
 <1307400613-13234-1-git-send-email-kys@microsoft.com>
 <1307400613-13234-24-git-send-email-kys@microsoft.com>
 <20110606231511.GB18222@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110606231511.GB18222@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Monday, June 06, 2011 7:15 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang;
> Abhishek Kane (Mindtree Consulting PVT LTD)
> Subject: Re: [PATCH 24/49] Staging: hv: vmbus: Get rid of the unused wrapper -
> vmbus_onchannel_event()
> 
> On Mon, Jun 06, 2011 at 03:49:48PM -0700, K. Y. Srinivasan wrote:
> > Now, get rid of the unused wrapper - vmbus_onchannel_event().
> 
> I'd merge this into the previous patch.  In general your patch split
> seem a little too fine grained to me in general.  When you remove a
> wrapper you can inline it into the callsite directly, if you clean up a
> function directly inlining it into the helper is fine, etc.
> 
I agree with you that some of these patches are too fine grained; but 
I thought that was what was expected - "one change per patch".

Regards,

K. Y

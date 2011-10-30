From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] Staging: hv: Move the mouse driver out of staging
Date: Sun, 30 Oct 2011 16:16:48 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481AA544E6@TK5EX14MBXC122.redmond.corp.microsoft.com>
References: <1319841316-29136-1-git-send-email-kys@microsoft.com>
 <alpine.LNX.2.00.1110290041500.31615@swampdragon.chaosbits.net>
 <20111029063240.GH14881@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111029063240.GH14881@longonot.mountain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Jesper Juhl <jj@chaosbits.net>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "jkosina@suse.cz" <jkosina@suse.cz>, "gregkh@suse.de" <gregkh@suse.de>, "ohering@suse.com" <ohering@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "joe@perches.com" <joe@perches.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Saturday, October 29, 2011 2:33 AM
> To: Jesper Juhl
> Cc: KY Srinivasan; dmitry.torokhov@gmail.com; jkosina@suse.cz;
> gregkh@suse.de; ohering@suse.com; linux-kernel@vger.kernel.org;
> virtualization@lists.osdl.org; joe@perches.com; devel@linuxdriverproject.org
> Subject: Re: [PATCH 1/1] Staging: hv: Move the mouse driver out of staging
> 
> On Sat, Oct 29, 2011 at 12:54:34AM +0200, Jesper Juhl wrote:
> > > +			default:
> > > +				pr_err("unhandled packet type %d, tid %llx len
> %d\n",
> > > +				   desc->type,
> > > +				   req_id,
> > > +				   bytes_recvd);
> >
> > Why not:
> >
> >                                 pr_err("unhandled packet type %d, tid %llx
> >                                        len %d\n", desc->type, req_id, bytes_recvd);
> 
> Because then the printk would be messed up?  Your final printed
> string would look like:
> 
> "unhandled packet type %d, tid %llx
>                                        len %d\n"
> 
> Don't break strings up across lines because it breaks grep.  If K. Y.
> wants to put all the parameters on one line instead of three that
> would probably be better, but in the end who cares?
> 
Thanks Dan.

Regards,

K. Y

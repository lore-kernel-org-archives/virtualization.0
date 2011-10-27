From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Staging: hv: mousevsc: Move the mouse driver out of
 staging
Date: Wed, 26 Oct 2011 17:09:27 -0700
Message-ID: <20111027000926.GB6804@core.coreip.homeip.net>
References: <1318658907-16698-1-git-send-email-kys@microsoft.com>
 <20111023072427.GA13268@core.coreip.homeip.net>
 <6E21E5352C11B742B20C142EB499E0481AA3369B@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481AA3369B@TK5EX14MBXC126.redmond.corp.microsoft.com>
Sender: linux-input-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Jiri Kosina <jkosina@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Oct 23, 2011 at 03:45:14PM +0000, KY Srinivasan wrote:
> > > +
> > > +	t = wait_for_completion_timeout(&input_dev->wait_event, 5*HZ);
> > > +	if (t == 0) {
> > > +		ret = -ETIMEDOUT;
> > > +		goto cleanup;
> > > +	}
> > > +
> > > +	response = &input_dev->protocol_resp;
> > > +
> > > +	if (!response->response.approved) {
> > > +		pr_err("synthhid protocol request failed (version %d)",
> > > +		       SYNTHHID_INPUT_VERSION);
> > > +		ret = -ENODEV;
> > > +		goto cleanup;
> > > +	}
> > > +
> > > +	t = wait_for_completion_timeout(&input_dev->wait_event, 5*HZ);
> > 
> > We just completed the wait for this completion, why are we waiting on
> > the same completion again?
> 
> In response to our initial query, we expect the host to respond back with two
> distinct pieces of information; we wait for both these responses.

I think you misunderstand how completion works in Linux. IIRC about
Windows events they are different ;) You can not signal completion
several times and then expect to wait corrsponding number of times. Once
you signal completion is it, well, complete.

>  
> > 
> > > +	if (t == 0) {
> > > +		ret = -ETIMEDOUT;
> > > +		goto cleanup;
> > > +	}
> > > +
> > > +	/*
> > > +	 * We should have gotten the device attr, hid desc and report
> > > +	 * desc at this point
> > > +	 */
> > > +	if (input_dev->dev_info_status)
> > > +		ret = -ENOMEM;
> > 
> > -ENOMEM seems wrong.
> > 
> There are many failures here and not being able to allocate memory is the 
> primary one; and so I chose to capture that.

Any chance that these failures have their own exit paths?

Thanks.

-- 
Dmitry

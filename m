From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/3] Drivers: hv: Support the newly introduced KVP
	messages in the driver
Date: Fri, 16 Mar 2012 06:33:35 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481B7666A2@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1331858893-775-1-git-send-email-kys@microsoft.com>
	<1331858925-827-1-git-send-email-kys@microsoft.com>
	<20120316054556.GH3163@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20120316054556.GH3163@mwanda>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "ohering@suse.com" <ohering@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Alan Stern <stern@rowland.harvard.edu>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Friday, March 16, 2012 1:46 AM
> To: KY Srinivasan
> Cc: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; ohering@suse.com;
> Alan Stern
> Subject: Re: [PATCH 1/3] Drivers: hv: Support the newly introduced KVP
> messages in the driver
> 
> On Thu, Mar 15, 2012 at 05:48:43PM -0700, K. Y. Srinivasan wrote:
> >  	/*
> >  	 * The windows host expects the key/value pair to be encoded
> >  	 * in utf16.
> >  	 */
> >  	keylen = utf8s_to_utf16s(key_name, strlen(key_name),
> UTF16_HOST_ENDIAN,
> > -				(wchar_t *) kvp_data->data.key,
> > +				(wchar_t *) kvp_data->key,
> >  				HV_KVP_EXCHANGE_MAX_KEY_SIZE / 2);
> > -	kvp_data->data.key_size = 2*(keylen + 1); /* utf16 encoding */
> > +	kvp_data->key_size = 2*(keylen + 1); /* utf16 encoding */
> > +
> 
> I feel like a jerk for asking this, but is the output length correct
> here?  It seems like we could go over again.  Also utf8s_to_utf16s()
> can return negative error codes, why do we ignore those?

We are returning the strings back to the host here. There are checks elsewhere
in the code to ensure that all strings we return to the host can be accommodated
in the available space. For the most part these are strings that the host gave us in the 
first place that have already been validated.  Furthermore, there are checks on the 
host side to ensure that the returned size parameters are consistent with the protocol 
definitions for the key value pair. For instance let us say somehow we got into a 
situation where the converted utf16 string occupied the entire MAX sized array 
without any room for the terminating character and we set the length parameter 
to 2 more than the MAX value as this code would do. The host would simply discard the 
message as an illegal message. This would be more appropriate than sending a 
truncated key or value.

With regards to the negative values, negative values indicate a failure of some sort
in the conversion. Since the host is the recipient here, host will correctly deal with the
transaction by discarding the tuple.  

Regards,

K. Y 

From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: Re: [PATCH]: An implementation of HyperV  KVP  functionality
Date: Fri, 12 Nov 2010 09:57:50 -0700
Message-ID: <4CDD0F9E020000300009038D@novprvoes0310.provo.novell.com>
References: <4CDBE98E02000030000902C9@novprvoes0310.provo.novell.com>
	<20101111124904.24010ee5@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20101111124904.24010ee5@nehalam>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, HaiyangZhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org



>>> On 11/11/2010 at  3:49 PM, in message <20101111124904.24010ee5@nehalam>,
Stephen Hemminger <shemminger@vyatta.com> wrote: 
> On Thu, 11 Nov 2010 13:03:10 -0700
> "Ky Srinivasan" <ksrinivasan@novell.com> wrote:
> 
>> +static char *kvp_keys[KVP_MAX_KEY] = {"FullyQualifiedDomainName",
>> +				"IntegrationServicesVersion",
>> +				"NetworkAddressIPv4",
>> +				"NetworkAddressIPv6",
>> +				"OSBuildNumber",
>> +				"OSName",
>> +				"OSMajorVersion",
>> +				"OSMinorVersion",
>> +				"OSVersion",
>> +				"ProcessorArchitecture",
>> +				};
> 
> Minor nit:
> static const char *kvp_keys[KVP_MAX_KEY] = {
> 	"FullQualifiedDomainName",
Will do.
> ...
> 
> +/*
> + * Global state maintained for transaction that is being processed.
> + * Note that only one transaction can be active at any point in time.
> + *
> + * This state is set when we receive a request from the host; we
> + * cleanup this state when the transaction is completed - when we respond
> + * to the host with the key value.
> + */
> +
> +static u8 *recv_buffer; /* the receive buffer that we allocated */
> +static int recv_len; /* number of bytes received. */
> +static struct vmbus_channel *recv_channel; /*chn on which we got the 
> request*/
> +static u64 recv_req_id; /* request ID. */
> +static int kvp_current_index;
> +
> 
> I would put all the state variables for the transaction in one
> structure,

Will do. 
> 
> +static void kvp_timer_func(unsigned long __data)
> +{
> +	u32	key = *((u32 *)__data);
> +	/*
> +	 * If the timer fires, the user-mode component has not responded;
> +	 * process the pending transaction.
> +	 */
> +	kvp_respond_to_host(key, "Guest timed out");
> +}
> 
> delayed_work is sometimes better for things like this, since it
> runs in user context and can sleep.
Although I don't need to block (sleep) in this code path, I agree with you having a  full context is preferable. I will make the appropriate changes.
> 
> +			case (KVP_MAX_KEY):
> +				/*
> +				 * We don't support this key
> +				 * and any key beyond this.
> +				 */
> +				icmsghdrp->status = HV_E_FAIL;
> +				goto callback_done;
> +
> 
> case labels do not need parens

Thank you; my next version of this patch will incorporate your feedback.

Regards,

K. Y

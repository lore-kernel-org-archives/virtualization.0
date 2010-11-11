From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: [PATCH]: An implementation of HyperV  KVP  functionality
Date: Thu, 11 Nov 2010 12:49:04 -0800
Message-ID: <20101111124904.24010ee5@nehalam>
References: <4CDBE98E02000030000902C9@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <4CDBE98E02000030000902C9@novprvoes0310.provo.novell.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Ky Srinivasan <ksrinivasan@novell.com>
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 11 Nov 2010 13:03:10 -0700
"Ky Srinivasan" <ksrinivasan@novell.com> wrote:

> +static char *kvp_keys[KVP_MAX_KEY] = {"FullyQualifiedDomainName",
> +				"IntegrationServicesVersion",
> +				"NetworkAddressIPv4",
> +				"NetworkAddressIPv6",
> +				"OSBuildNumber",
> +				"OSName",
> +				"OSMajorVersion",
> +				"OSMinorVersion",
> +				"OSVersion",
> +				"ProcessorArchitecture",
> +				};

Minor nit:
static const char *kvp_keys[KVP_MAX_KEY] = {
	"FullQualifiedDomainName",
...

+/*
+ * Global state maintained for transaction that is being processed.
+ * Note that only one transaction can be active at any point in time.
+ *
+ * This state is set when we receive a request from the host; we
+ * cleanup this state when the transaction is completed - when we respond
+ * to the host with the key value.
+ */
+
+static u8 *recv_buffer; /* the receive buffer that we allocated */
+static int recv_len; /* number of bytes received. */
+static struct vmbus_channel *recv_channel; /*chn on which we got the request*/
+static u64 recv_req_id; /* request ID. */
+static int kvp_current_index;
+

I would put all the state variables for the transaction in one
structure, 

+static void kvp_timer_func(unsigned long __data)
+{
+	u32	key = *((u32 *)__data);
+	/*
+	 * If the timer fires, the user-mode component has not responded;
+	 * process the pending transaction.
+	 */
+	kvp_respond_to_host(key, "Guest timed out");
+}

delayed_work is sometimes better for things like this, since it
runs in user context and can sleep.

+			case (KVP_MAX_KEY):
+				/*
+				 * We don't support this key
+				 * and any key beyond this.
+				 */
+				icmsghdrp->status = HV_E_FAIL;
+				goto callback_done;
+

case labels do not need parens

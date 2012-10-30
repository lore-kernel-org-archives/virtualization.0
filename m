From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/12] VMCI: event handling implementation.
Date: Mon, 29 Oct 2012 19:24:46 -0700
Message-ID: <20121030022446.GF1920@kroah.com>
References: <20121030005923.17788.21797.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121030010420.17788.59187.stgit@promb-2n-dhcp175.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121030010420.17788.59187.stgit@promb-2n-dhcp175.eng.vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: George Zhang <georgezhang@vmware.com>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 29, 2012 at 06:04:27PM -0700, George Zhang wrote:
> +/*
> + * Releases the given VMCISubscription.
> + * Fires the destroy event if the reference count has gone to zero.
> + */
> +static void event_release(struct vmci_subscription *entry)
> +{
> +	kref_put(&entry->kref, event_signal_destroy);
> +}

Same question as before with the kref_put() call, what is handling the
locking here?  It looks like a race to me.

thanks,

greg k-h

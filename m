From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 07/12] VMCI: queue pairs implementation.
Date: Thu, 15 Nov 2012 15:48:55 -0800
Message-ID: <20121115234855.GA8369@kroah.com>
References: <20121107183624.9658.78903.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121107184210.9658.57625.stgit@promb-2n-dhcp175.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121107184210.9658.57625.stgit@promb-2n-dhcp175.eng.vmware.com>
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

On Wed, Nov 07, 2012 at 10:42:15AM -0800, George Zhang wrote:
> VMCI queue pairs allow for bi-directional ordered communication between host and guests.

You obviously didn't run checkpatch on this file :(

Please send me a follow-on patch to resolve the issues it found, before
someone else does...

thanks,

greg k-h

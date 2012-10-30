From: Dmitry Torokhov <dtor@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 08/12] VMCI: resource object implementation.
Date: Mon, 29 Oct 2012 22:21:52 -0700
Message-ID: <20121030052152.GG32055@dtor-ws.eng.vmware.com>
References: <20121030005923.17788.21797.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121030010453.17788.90295.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121030022946.GI1920@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121030022946.GI1920@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 29, 2012 at 07:29:46PM -0700, Greg KH wrote:
> On Mon, Oct 29, 2012 at 06:04:58PM -0700, George Zhang wrote:
> > VMCI resource tracks all used resources within the vmci code.
> 
> Same "kref_put() with no lock seen" question in this file, prove me
> wrong please.

Same proof as with others, the reference can't be taken unless the
resource is in hast table (which protected by RCU/spinlock) so no fear
of bouncing off 0.

Thanks,
Dmitry

From: Andy King <acking@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 04/10] VMCI: device driver implementaton.
Date: Thu, 25 Oct 2012 13:16:00 -0700 (PDT)
Message-ID: <574849395.2604157.1351196160882.JavaMail.root@vmware.com>
References: <20121025192851.GA26627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121025192851.GA26627@kroah.com>
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
Cc: pv-drivers@vmware.com, vm-crosstalk@vmware.com, linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Greg,

> > +EXPORT_SYMBOL(vmci_device_get);
> 
> EXPORT_SYMBOL_GPL() for this, and all other exports?

We'd prefer to leave them as vanilla exports.  While we're committed
to open-sourcing everything, including our non-upstreamed drivers,
we don't really have a strong opinion regarding consuming our exports
in closed-source (general GPL issues aside).

> And it seems that you have a bunch of "unused" parameters for this,
> and other public functions.  Please just remove them entirely.

Will do.

Also, regarding that particular public function, it seems to have slipped
through the cracks.  It's an artifact of the API being cross-platform
prior to upstreaming.  On Linux, it makes no sense whatsoever, so we'll
just yank it completely.

Thanks!
- Andy

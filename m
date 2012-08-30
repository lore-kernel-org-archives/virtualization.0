From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/11] vmci_context.patch: VMCI context list operations.
Date: Thu, 30 Aug 2012 13:57:29 -0700
Message-ID: <20120830205729.GA3276@kroah.com>
References: <20120824171042.4775.36871.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20120824171551.4775.87175.stgit@promb-2n-dhcp175.eng.vmware.com>
	<15333E71B3DDCB48A90165AD57993F285685DB43D7@exch-mbx-114.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <15333E71B3DDCB48A90165AD57993F285685DB43D7@exch-mbx-114.vmware.com>
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 30, 2012 at 09:38:08AM -0700, George Zhang wrote:
> +/* VMCICptBufInfo: Used to set/get current context's checkpoint state. */
> +struct vmci_ctx_chkpt_buf_info {
> +       uint64_t cptBuf;
> +       uint32_t cptType;
> +       uint32_t bufSize;
> +       int32_t result;
> +       uint32_t _pad;
> +};

Please use the proper kernel types when you are passing structures
across the kernel/user boundry (hint, you should NEVER be using the
uint*_t types in the kernel).  You need to fix up all of the structures
that you pass through your ioctl, to use the correct __ types, and fix
up everything else to use the other types.

Also, you have a crazy variable naming scheme everywhere, remember, you
can use vowels and '_' characters :)

greg k-h

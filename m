From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [vmw_vmci 11/11] Apply the header code to make VMCI build
Date: Fri, 27 Jul 2012 10:53:57 +0100
Message-ID: <20120727105357.2e40dd10@pyramind.ukuu.org.uk>
References: <1343345980-32397-1-git-send-email-astiegmann@vmware.com>
	<1343345980-32397-12-git-send-email-astiegmann@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1343345980-32397-12-git-send-email-astiegmann@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Andrew Stiegmann (stieg)" <astiegmann@vmware.com>
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, vm-crosstalk@vmware.com, cschamp@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

> +enum {
> +	VMCI_SUCCESS_QUEUEPAIR_ATTACH	=  5,
> +	VMCI_SUCCESS_QUEUEPAIR_CREATE	=  4,
> +	VMCI_SUCCESS_LAST_DETACH	=  3,
> +	VMCI_SUCCESS_ACCESS_GRANTED	=  2,
> +	VMCI_SUCCESS_ENTRY_DEAD	=  1,

We've got a nice collection of Linux error codes than you, and it would
make the driver enormously more readable on the Linux side if as low
level as possible it started using Linux error codes.


> +	VMCI_SUCCESS			=  0,
> +	VMCI_ERROR_INVALID_RESOURCE	= (-1),
> +	VMCI_ERROR_INVALID_ARGS	= (-2),
> +	VMCI_ERROR_NO_MEM		= (-3),
> +	VMCI_ERROR_DATAGRAM_FAILED	= (-4),
> +	VMCI_ERROR_MORE_DATA		= (-5),
> +	VMCI_ERROR_NO_MORE_DATAGRAMS	= (-6),
> +	VMCI_ERROR_NO_ACCESS		= (-7),
> +	VMCI_ERROR_NO_HANDLE		= (-8),
> +	VMCI_ERROR_DUPLICATE_ENTRY	= (-9),
> +	VMCI_ERROR_DST_UNREACHABLE	= (-10),
> +	VMCI_ERROR_PAYLOAD_TOO_LARGE	= (-11),
> +	VMCI_ERROR_INVALID_PRIV	= (-12),

From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] VSOCK: Send reset control packet when socket is
	partially bound
Date: Tue, 18 Dec 2018 11:54:33 -0800 (PST)
Message-ID: <20181218.115433.2044623159542485583.davem__47145.0238409036$1545162754$gmane$org@davemloft.net>
References: <1545122046-43955-1-git-send-email-jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1545122046-43955-1-git-send-email-jhansen@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jhansen@vmware.com
Cc: pv-drivers@vmware.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jorgen Hansen <jhansen@vmware.com>
Date: Tue, 18 Dec 2018 00:34:06 -0800

> If a server side socket is bound to an address, but not in the listening
> state yet, incoming connection requests should receive a reset control
> packet in response. However, the function used to send the reset
> silently drops the reset packet if the sending socket isn't bound
> to a remote address (as is the case for a bound socket not yet in
> the listening state). This change fixes this by using the src
> of the incoming packet as destination for the reset packet in
> this case.
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Reviewed-by: Adit Ranadive <aditr@vmware.com>
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>

Applied and queued up for -stable, thanks.

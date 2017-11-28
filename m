From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] VSOCK: Don't set sk_state to TCP_CLOSE before testing it
Date: Tue, 28 Nov 2017 16:02:04 -0500 (EST)
Message-ID: <20171128.160204.772077471252633195.davem__6579.56237341768$1511902948$gmane$org@davemloft.net>
References: <1511789372-12672-1-git-send-email-jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1511789372-12672-1-git-send-email-jhansen@vmware.com>
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
Cc: pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, gregkh@linuxfoundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jorgen Hansen <jhansen@vmware.com>
Date: Mon, 27 Nov 2017 05:29:32 -0800

> A recent commit (3b4477d2dcf2) converted the sk_state to use
> TCP constants. In that change, vmci_transport_handle_detach
> was changed such that sk->sk_state was set to TCP_CLOSE before
> we test whether it is TCP_SYN_SENT. This change moves the
> sk_state change back to the original locations in that function.
> 
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>

Applied.

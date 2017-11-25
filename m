From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] VSOCK: Don't call vsock_stream_has_data in atomic
	context
Date: Sun, 26 Nov 2017 04:22:21 +0900 (KST)
Message-ID: <20171126.042221.596692527873080042.davem__42159.7541463145$1511637811$gmane$org@davemloft.net>
References: <1511533528-5253-1-git-send-email-jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1511533528-5253-1-git-send-email-jhansen@vmware.com>
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
Date: Fri, 24 Nov 2017 06:25:28 -0800

> When using the host personality, VMCI will grab a mutex for any
> queue pair access. In the detach callback for the vmci vsock
> transport, we call vsock_stream_has_data while holding a spinlock,
> and vsock_stream_has_data will access a queue pair.
> 
> To avoid this, we can simply omit calling vsock_stream_has_data
> for host side queue pairs, since the QPs are empty per default
> when the guest has detached.
> 
> This bug affects users of VMware Workstation using kernel version
> 4.4 and later.
> 
> Testing: Ran vsock tests between guest and host, and verified that
> with this change, the host isn't calling vsock_stream_has_data
> during detach. Ran mixedTest between guest and host using both
> guest and host as server.
> 
> v2: Rebased on top of recent change to sk_state values
> Reviewed-by: Adit Ranadive <aditr@vmware.com>
> Reviewed-by: Aditya Sarwade <asarwade@vmware.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>

Applied, thank you.

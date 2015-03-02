From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: init work unconditionally
Date: Mon, 2 Mar 2015 11:26:09 +0530
Message-ID: <20150302055609.GD26196__40531.1433402405$1425275805$gmane$org@grmbl.mre>
References: <1425145274-27864-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1425145274-27864-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Sat) 28 Feb 2015 [18:41:34], Michael S. Tsirkin wrote:
> when multiport is off, we don't initialize config work,
> but we then cancel uninitialized control_work on freeze.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Amit Shah <amit.shah@redhat.com>

		Amit

From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH v2] virtio_balloon: Convert "vballon" kthread into a
	workqueue
Date: Wed, 12 Nov 2014 12:50:37 -0600
Message-ID: <20141112185037.GB53560__9877.47597178004$1415820733$gmane$org@unpythonic.net>
References: <1415797368-22660-1-git-send-email-pmladek@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1415797368-22660-1-git-send-email-pmladek@suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Petr Mladek <pmladek@suse.cz>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Trivial typo "vballon" should be "vballoon" in subject (and in changelog,
leak_ballon should be leak_balloon)

Jeff

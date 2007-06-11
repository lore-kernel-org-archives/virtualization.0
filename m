From: "ron minnich" <rminnich@gmail.com>
Subject: Re: [Xen-devel] More virtio users
Date: Sun, 10 Jun 2007 20:04:50 -0700
Message-ID: <13426df10706102004s6898c15bu254c1527d640a474__12810.7004370124$1181531186$gmane$org@mail.gmail.com>
References: <466BA965.6050208@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <466BA965.6050208@qumranet.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 6/10/07, Avi Kivity <avi@qumranet.com> wrote:

> There are probably more.  Any ideas?

sessions to 9p servers. But if we had a way to, first, do PV that
send/receive to an fd pair, that would be a start.

ron

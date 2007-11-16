From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: paravirt_alloc_pd_clone() useful?
Date: Fri, 16 Nov 2007 11:24:22 -0800
Message-ID: <473DEE66.1020507@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Do you use paravirt_alloc_pd_clone()?  I seem to you remember you
mentioning that it doesn't help you very much.  I'm in the process of
unifying pgalloc*, and it seems to me that it would be a bit cleaner
without needing to worry about paravirt_alloc_pd_clone()...

    J
